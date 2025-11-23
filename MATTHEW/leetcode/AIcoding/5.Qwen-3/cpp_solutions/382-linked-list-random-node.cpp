#include <iostream>
#include <vector>
#include <cstdlib>
#include <ctime>

using namespace std;

struct ListNode {
    int val;
    ListNode *next;
    ListNode(int x) : val(x), next(NULL) {}
};

class Solution {
public:
    Solution(ListNode* head) {
        this->head = head;
        srand(time(0));
    }

    int getRandom() {
        int result = 0;
        int count = 0;
        ListNode* current = head;
        while (current) {
            count++;
            if (rand() % count == 0) {
                result = current->val;
            }
            current = current->next;
        }
        return result;
    }

private:
    ListNode* head;
};