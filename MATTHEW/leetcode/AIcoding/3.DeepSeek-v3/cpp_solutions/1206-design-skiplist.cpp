class Skiplist {
private:
    struct Node {
        int val;
        vector<Node*> next;
        Node(int v, int level) : val(v), next(level, nullptr) {}
    };

    Node* head;
    int maxLevel;
    double p;
    int randomLevel() {
        int level = 1;
        while ((rand() % 100) < p * 100 && level < maxLevel) {
            level++;
        }
        return level;
    }

public:
    Skiplist() {
        maxLevel = 16;
        p = 0.5;
        head = new Node(-1, maxLevel);
    }

    bool search(int target) {
        Node* curr = head;
        for (int i = maxLevel - 1; i >= 0; --i) {
            while (curr->next[i] && curr->next[i]->val < target) {
                curr = curr->next[i];
            }
        }
        curr = curr->next[0];
        return curr && curr->val == target;
    }

    void add(int num) {
        vector<Node*> update(maxLevel, head);
        Node* curr = head;
        for (int i = maxLevel - 1; i >= 0; --i) {
            while (curr->next[i] && curr->next[i]->val < num) {
                curr = curr->next[i];
            }
            update[i] = curr;
        }
        int level = randomLevel();
        Node* newNode = new Node(num, level);
        for (int i = 0; i < level; ++i) {
            newNode->next[i] = update[i]->next[i];
            update[i]->next[i] = newNode;
        }
    }

    bool erase(int num) {
        vector<Node*> update(maxLevel, nullptr);
        Node* curr = head;
        for (int i = maxLevel - 1; i >= 0; --i) {
            while (curr->next[i] && curr->next[i]->val < num) {
                curr = curr->next[i];
            }
            update[i] = curr;
        }
        curr = curr->next[0];
        if (!curr || curr->val != num) {
            return false;
        }
        for (int i = 0; i < curr->next.size(); ++i) {
            if (update[i]->next[i] != curr) {
                break;
            }
            update[i]->next[i] = curr->next[i];
        }
        delete curr;
        return true;
    }
};