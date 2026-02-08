class Solution {
public:
    ListNode* reverseEvenLengthGroups(ListNode* head) {
        ListNode* curr = head;
        int k = 1;
        while (curr != nullptr) {
            ListNode* temp = curr;
            int count = 0;
            while (temp != nullptr && count < k) {
                temp = temp->next;
                count++;
            }
            if (count % 2 == 0) {
                ListNode* prev = nullptr;
                ListNode* next = nullptr;
                ListNode* subCurr = curr;
                ListNode* tail = curr;
                int subCount = 0;
                while (subCurr != nullptr && subCount < k) {
                    next = subCurr->next;
                    subCurr->next = prev;
                    prev = subCurr;
                    subCurr = next;
                    subCount++;
                }
                if(curr == head){
                    head = prev;
                } else{
                    ListNode* prevGroupTail = head;
                    int group = 1;
                    while(group < k){
                        ListNode* temp2 = head;
                        for(int i = 1; i < group; i++){
                            temp2 = temp2->next;
                        }
                        prevGroupTail = temp2;
                        group++;
                    }

                    ListNode* temp2 = head;
                    int num = 1;
                    while(num < k){
                        temp2 = temp2->next;
                        num++;
                    }

                    ListNode* p = head;
                    int l = 1;
                    while(l < k){
                         p = p->next;
                         l++;
                    }
                    if(curr != head)
                    {
                        ListNode* findPre = head;
                        while(findPre->next != curr){
                            findPre = findPre->next;
                        }
                        findPre->next = prev;
                    }

                }
                tail->next = temp;
                curr = temp;
            } else {
                for (int i = 0; i < k && curr != nullptr; i++) {
                    curr = curr->next;
                }
            }
            k++;
        }
        return head;
    }
};