class MyLinkedList {
private:
    struct Node {
        int val;
        Node* next;
        Node* prev;
        Node(int v) : val(v), next(nullptr), prev(nullptr) {}
    };

    Node* head;
    Node* tail;
    int size;

public:
    MyLinkedList() {
        size = 0;
        head = new Node(0);
        tail = new Node(0);
        head->next = tail;
        tail->prev = head;
    }

    int get(int index) {
        if (index < 0 || index >= size) {
            return -1;
        }
        Node* curr;
        if (index < size / 2) {
            curr = head->next;
            for (int i = 0; i < index; ++i) {
                curr = curr->next;
            }
        } else {
            curr = tail->prev;
            for (int i = 0; i < size - 1 - index; ++i) {
                curr = curr->prev;
            }
        }
        return curr->val;
    }

    void addAtHead(int val) {
        addAtIndex(0, val);
    }

    void addAtTail(int val) {
        addAtIndex(size, val);
    }

    void addAtIndex(int index, int val) {
        if (index > size) {
            return;
        }
        if (index < 0) {
            index = 0;
        }

        Node* pred;
        Node* succ;
        if (index < size / 2) {
            pred = head;
            for (int i = 0; i < index; ++i) {
                pred = pred->next;
            }
            succ = pred->next;
        } else {
            succ = tail;
            for (int i = 0; i < size - index; ++i) {
                succ = succ->prev;
            }
            pred = succ->prev;
        }

        Node* newNode = new Node(val);
        newNode->prev = pred;
        newNode->next = succ;
        pred->next = newNode;
        succ->prev = newNode;

        size++;
    }

    void deleteAtIndex(int index) {
        if (index < 0 || index >= size) {
            return;
        }

        Node* curr;
        if (index < size / 2) {
            curr = head->next;
            for (int i = 0; i < index; ++i) {
                curr = curr->next;
            }
        } else {
            curr = tail->prev;
            for (int i = 0; i < size - 1 - index; ++i) {
                curr = curr->prev;
            }
        }

        Node* pred = curr->prev;
        Node* succ = curr->next;

        pred->next = succ;
        succ->prev = pred;

        delete curr;
        size--;
    }
};