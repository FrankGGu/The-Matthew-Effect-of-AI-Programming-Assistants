var Solution = function(head) {
    this.head = head;
};

Solution.prototype.getRandom = function() {
    let scope = 1, chosenValue = null;
    let curr = this.head;
    while (curr) {
        if (Math.random() < 1 / scope) {
            chosenValue = curr.val;
        }
        scope++;
        curr = curr.next;
    }
    return chosenValue;
};