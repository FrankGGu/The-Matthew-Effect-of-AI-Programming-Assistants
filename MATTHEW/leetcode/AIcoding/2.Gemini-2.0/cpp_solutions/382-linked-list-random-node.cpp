#include <vector>
#include <cstdlib>
#include <ctime>

using namespace std;

struct ListNode {
    int val;
    ListNode *next;
    ListNode() : val(0), next(nullptr) {}
    ListNode(int x) : val(x), next(nullptr) {}
    ListNode(int x, ListNode *next) : val(x), next(next) {}
};

class Solution {
private:
    ListNode* head;
public:
    Solution(ListNode* head) {
        this->head = head;
        srand(time(0));
    }

    int getRandom() {
        int res = 0;
        int count = 0;
        ListNode* curr = head;
        while (curr != nullptr) {
            count++;
            if (rand() % count == 0) {
                res = curr->val;
            }
            curr = curr->next;
        }
        return res;
    }
};