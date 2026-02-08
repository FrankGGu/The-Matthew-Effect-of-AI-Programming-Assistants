class Solution {
    constructor(head) {
        this.head = head;
        this.current = head;
    }

    getRandom() {
        let result = this.head.val;
        let node = this.head;
        let index = 1;

        while (node) {
            if (Math.random() * index < 1) {
                result = node.val;
            }
            node = node.next;
            index++;
        }

        return result;
    }
}