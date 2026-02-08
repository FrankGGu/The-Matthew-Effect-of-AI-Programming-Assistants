#include <vector>
#include <random>
#include <chrono>

struct Node {
    int val;
    std::vector<Node*> next;

    Node(int v, int num_levels) : val(v), next(num_levels, nullptr) {}
};

class Skiplist {
private:
    static const int MAX_LEVEL = 16;
    Node* head;
    int current_max_level;
    std::mt19937 rng;
    std::uniform_int_distribution<int> dist;

    int getRandomLevel() {
        int level = 1;
        while (dist(rng) == 0 && level < MAX_LEVEL) {
            level++;
        }
        return level;
    }

public:
    Skiplist() {
        head = new Node(-1, MAX_LEVEL);
        current_max_level = 0;
        rng.seed(std::chrono::high_resolution_clock::now().time_since_epoch().count());
        dist = std::uniform_int_distribution<int>(0, 1);
    }

    ~Skiplist() {
        Node* current = head->next[0];
        while (current) {
            Node* temp = current;
            current = current->next[0];
            delete temp;
        }
        delete head;
    }

    bool search(int target) {
        Node* current = head;
        for (int i = current_max_level - 1; i >= 0; --i) {
            while (current->next[i] != nullptr && current->next[i]->val < target) {
                current = current->next[i];
            }
        }
        current = current->next[0];
        return current != nullptr && current->val == target;
    }

    void add(int num) {
        std::vector<Node*> update(MAX_LEVEL);
        Node* current = head;

        for (int i = current_max_level - 1; i >= 0; --i) {
            while (current->next[i] != nullptr && current->next[i]->val < num) {
                current = current->next[i];
            }
            update[i] = current;
        }

        int new_level = getRandomLevel();
        if (new_level > current_max_level) {
            for (int i = current_max_level; i < new_level; ++i) {
                update[i] = head;
            }
            current_max_level = new_level;
        }

        Node* new_node = new Node(num, new_level);

        for (int i = 0; i < new_level; ++i) {
            new_node->next[i] = update[i]->next[i];
            update[i]->next[i] = new_node;
        }
    }

    bool erase(int num) {
        std::vector<Node*> update(MAX_LEVEL);
        Node* current = head;

        for (int i = current_max_level - 1; i >= 0; --i) {
            while (current->next[i] != nullptr && current->next[i]->val < num) {
                current = current->next[i];
            }
            update[i] = current;
        }

        current = current->next[0];
        if (current == nullptr || current->val != num) {
            return false;
        }

        for (int i = 0; i < current_max_level; ++i) {
            if (update[i]->next[i] == current) {
                update[i]->next[i] = current->next[i];
            }
        }

        delete current;

        while (current_max_level > 1 && head->next[current_max_level - 1] == nullptr) {
            current_max_level--;
        }

        return true;
    }
};