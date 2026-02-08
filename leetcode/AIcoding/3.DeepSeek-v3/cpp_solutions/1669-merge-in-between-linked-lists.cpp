class Solution {
public:
    ListNode* mergeInBetween(ListNode* list1, int a, int b, ListNode* list2) {
        ListNode *prevA = nullptr, *nodeB = nullptr;
        ListNode *current = list1;
        int index = 0;

        while (current != nullptr) {
            if (index == a - 1) {
                prevA = current;
            }
            if (index == b) {
                nodeB = current->next;
                break;
            }
            current = current->next;
            index++;
        }

        ListNode *tailList2 = list2;
        while (tailList2->next != nullptr) {
            tailList2 = tailList2->next;
        }

        prevA->next = list2;
        tailList2->next = nodeB;

        return list1;
    }
};