class Skiplist {
public:
    struct Node {
        int val;
        vector<Node*> forward;
        Node(int v, int level) : val(v), forward(level, nullptr) {}
    };

    Skiplist() {
        srand(time(0));
        head = new Node(-1, MAX_LEVEL);
    }

    bool search(int target) {
        Node* curr = head;
        for (int i = level - 1; i >= 0; --i) {
            while (curr->forward[i] && curr->forward[i]->val < target) {
                curr = curr->forward[i];
            }
        }
        curr = curr->forward[0];
        return curr && curr->val == target;
    }

    void add(int num) {
        Node* curr = head;
        vector<Node*> update(MAX_LEVEL);
        for (int i = level - 1; i >= 0; --i) {
            while (curr->forward[i] && curr->forward[i]->val < num) {
                curr = curr->forward[i];
            }
            update[i] = curr;
        }
        curr = curr->forward[0];
        if (!curr || curr->val != num) {
            int lvl = randomLevel();
            if (lvl > level) {
                for (int i = level; i < lvl; ++i) {
                    update[i] = head;
                }
                level = lvl;
            }
            Node* newNode = new Node(num, lvl);
            for (int i = 0; i < lvl; ++i) {
                newNode->forward[i] = update[i]->forward[i];
                update[i]->forward[i] = newNode;
            }
        }
    }

    bool erase(int num) {
        Node* curr = head;
        vector<Node*> update(MAX_LEVEL);
        for (int i = level - 1; i >= 0; --i) {
            while (curr->forward[i] && curr->forward[i]->val < num) {
                curr = curr->forward[i];
            }
            update[i] = curr;
        }
        curr = curr->forward[0];
        if (curr && curr->val == num) {
            for (int i = 0; i < level; ++i) {
                if (update[i]->forward[i] != curr) break;
                update[i]->forward[i] = curr->forward[i];
            }
            delete curr;
            while (level > 1 && !head->forward[level - 1]) {
                --level;
            }
            return true;
        }
        return false;
    }

private:
    Node* head;
    int level = 1;
    static const int MAX_LEVEL = 16;

    int randomLevel() {
        int lvl = 1;
        while (lvl < MAX_LEVEL && rand() % 2) {
            ++lvl;
        }
        return lvl;
    }
};