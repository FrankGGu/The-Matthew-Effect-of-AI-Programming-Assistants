#include <iostream>
#include <vector>
#include <cstdlib>
#include <ctime>

using namespace std;

class Skiplist {
private:
    struct Node {
        int val;
        vector<Node*> next;
        Node(int v, int level) : val(v), next(level, nullptr) {}
    };

    int max_level;
    double probability;
    Node* head;

    int randomLevel() {
        int level = 1;
        while (rand() / (double)RAND_MAX < probability && level < max_level) {
            level++;
        }
        return level;
    }

public:
    Skiplist() : max_level(16), probability(0.5), head(new Node(0, max_level)) {}

    bool search(int target) {
        Node* current = head;
        for (int i = max_level - 1; i >= 0; i--) {
            while (current->next[i] && current->next[i]->val < target) {
                current = current->next[i];
            }
        }
        current = current->next[0];
        return current && current->val == target;
    }

    void add(int target) {
        Node* current = head;
        vector<Node*> update(max_level, head);
        for (int i = max_level - 1; i >= 0; i--) {
            while (current->next[i] && current->next[i]->val < target) {
                current = current->next[i];
            }
            update[i] = current;
        }
        int level = randomLevel();
        Node* newNode = new Node(target, level);
        for (int i = 0; i < level; i++) {
            newNode->next[i] = update[i]->next[i];
            update[i]->next[i] = newNode;
        }
    }

    bool erase(int target) {
        Node* current = head;
        vector<Node*> update(max_level, nullptr);
        for (int i = max_level - 1; i >= 0; i--) {
            while (current->next[i] && current->next[i]->val < target) {
                current = current->next[i];
            }
            update[i] = current;
        }
        current = current->next[0];
        if (!current || current->val != target) {
            return false;
        }
        for (int i = 0; i < max_level; i++) {
            if (update[i]->next[i] != current) break;
            update[i]->next[i] = current->next[i];
        }
        delete current;
        return true;
    }
};

class Solution {
public:
    Skiplist* skiplistCreate() {
        return new Skiplist();
    }

    void skiplistInsert(Skiplist* obj, int num) {
        obj->add(num);
    }

    bool skiplistSearch(Skiplist* obj, int target) {
        return obj->search(target);
    }

    void skiplistDelete(Skiplist* obj, int num) {
        obj->erase(num);
    }

    void skiplistFree(Skiplist* obj) {
        delete obj;
    }
};