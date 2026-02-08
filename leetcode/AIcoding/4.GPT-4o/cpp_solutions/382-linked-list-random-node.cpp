#include <vector>
#include <ctime>
#include <cstdlib>

class LinkedListNode {
public:
    int val;
    LinkedListNode *next;
    LinkedListNode(int x) : val(x), next(nullptr) {}
};

class Solution {
private:
    std::vector<int> values;

public:
    Solution(LinkedListNode* head) {
        while (head) {
            values.push_back(head->val);
            head = head->next;
        }
        srand(time(0));
    }

    int getRandom() {
        return values[rand() % values.size()];
    }
};