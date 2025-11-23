#include <vector>
#include <cstdlib>

class Skiplist {
private:
    struct Node {
        int val;
        std::vector<Node*> forward;
        Node(int v, int level) : val(v), forward(level, nullptr) {}
    };

    int level;
    int maxLevel;
    float probability;
    Node* head;

public:
    Skiplist() : level(1), maxLevel(16), probability(0.5) {
        head = new Node(-1, maxLevel);
    }

    bool search(int target) {
        Node* curr = head;
        for (int i = level - 1; i >= 0; --i) {
            while (curr->forward[i] != nullptr && curr->forward[i]->val < target) {
                curr = curr->forward[i];
            }
        }
        return curr->forward[0] != nullptr && curr->forward[0]->val == target;
    }

    void add(int num) {
        std::vector<Node*> update(maxLevel, nullptr);
        Node* curr = head;
        for (int i = level - 1; i >= 0; --i) {
            while (curr->forward[i] != nullptr && curr->forward[i]->val < num) {
                curr = curr->forward[i];
            }
            update[i] = curr;
        }

        int newLevel = randomLevel();
        if (newLevel > level) {
            for (int i = level; i < newLevel; ++i) {
                update[i] = head;
            }
            level = newLevel;
        }

        Node* newNode = new Node(num, newLevel);
        for (int i = 0; i < newLevel; ++i) {
            newNode->forward[i] = update[i]->forward[i];
            update[i]->forward[i] = newNode;
        }
    }

    bool erase(int num) {
        std::vector<Node*> update(maxLevel, nullptr);
        Node* curr = head;
        for (int i = level - 1; i >= 0; --i) {
            while (curr->forward[i] != nullptr && curr->forward[i]->val < num) {
                curr = curr->forward[i];
            }
            update[i] = curr;
        }

        if (curr->forward[0] == nullptr || curr->forward[0]->val != num) {
            return false;
        }

        Node* toDelete = curr->forward[0];
        for (int i = 0; i < level; ++i) {
            if (update[i]->forward[i] != toDelete) {
                break;
            }
            update[i]->forward[i] = toDelete->forward[i];
        }

        while (level > 1 && head->forward[level - 1] == nullptr) {
            level--;
        }

        delete toDelete;
        return true;
    }

private:
    int randomLevel() {
        int lvl = 1;
        while (rand() < RAND_MAX * probability && lvl < maxLevel) {
            lvl++;
        }
        return lvl;
    }
};