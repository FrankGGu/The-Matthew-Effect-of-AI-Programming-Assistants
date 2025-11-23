var Solution = function(head) {
    this.head = head;
};

Solution.prototype.getRandom = function() {
    let result = 0;
    let current = this.head;
    let n = 0;

    while (current) {
        n++;
        if (Math.random() < 1 / n) {
            result = current.val;
        }
        current = current.next;
    }

    return result;
};