var Solution = function(head) {
    this.list = [];
    while (head) {
        this.list.push(head.val);
        head = head.next;
    }
};

Solution.prototype.getRandom = function() {
    const randomIndex = Math.floor(Math.random() * this.list.length);
    return this.list[randomIndex];
};