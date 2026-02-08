#include <iostream>
#include <unordered_map>

using namespace std;

struct ListNode {
    int val;
    ListNode *next;
    ListNode(int x) : val(x), next(nullptr) {}
};

class Solution {
public:
    ListNode *getIntersectionNode(ListNode *headA, ListNode *headB) {
        unordered_map<ListNode*, int> nodeMap;
        while (headA) {
            nodeMap[headA]++;
            headA = headA->next;
        }
        while (headB) {
            if (nodeMap.find(headB) != nodeMap.end()) {
                return headB;
            }
            headB = headB->next;
        }
        return nullptr;
    }
};