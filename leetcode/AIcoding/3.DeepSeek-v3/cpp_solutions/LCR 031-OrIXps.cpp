using namespace std;

struct ListNode {
    int key;
    int val;
    ListNode* prev;
    ListNode* next;
    ListNode(int k, int v) : key(k), val(v), prev(nullptr), next(nullptr) {}
};

class LRUCache {
private:
    int capacity;
    int size;
    unordered_map<int, ListNode*> cache;
    ListNode* dummyHead;
    ListNode* dummyTail;

    void addNode(ListNode* node) {
        node->prev = dummyHead;
        node->next = dummyHead->next;
        dummyHead->next->prev = node;
        dummyHead->next = node;
    }

    void removeNode(ListNode* node) {
        ListNode* prevNode = node->prev;
        ListNode* nextNode = node->next;
        prevNode->next = nextNode;
        nextNode->prev = prevNode;
    }

    void moveToHead(ListNode* node) {
        removeNode(node);
        addNode(node);
    }

    ListNode* popTail() {
        ListNode* res = dummyTail->prev;
        removeNode(res);
        return res;
    }

public:
    LRUCache(int capacity) : capacity(capacity), size(0) {
        dummyHead = new ListNode(-1, -1);
        dummyTail = new ListNode(-1, -1);
        dummyHead->next = dummyTail;
        dummyTail->prev = dummyHead;
    }

    ~LRUCache() {
        ListNode* cur = dummyHead;
        while (cur) {
            ListNode* next = cur->next;
            delete cur;
            cur = next;
        }
    }

    int get