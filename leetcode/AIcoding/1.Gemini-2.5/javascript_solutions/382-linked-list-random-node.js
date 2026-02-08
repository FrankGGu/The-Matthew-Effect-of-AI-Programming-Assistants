var Solution = function(head) {
    this.head = head;
};

Solution.prototype.getRandom = function() {
    let current = this.head;
    let result = 0;
    let count = 0;

    while (current !== null) {
        if (Math.floor(Math.random() * (count + 1)) === 0) {
            result = current.val;
        }
        current = current.next;
        count++;
    }
    return result;
};