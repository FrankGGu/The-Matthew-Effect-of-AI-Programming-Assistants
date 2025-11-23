var Skiplist = function() {
    this.levels = [];
};

Skiplist.prototype.search = function(target) {
    let current = this.levels[0];
    while (current) {
        if (current.val === target) return true;
        else if (current.val < target) current = current.next;
        else {
            if (current.down) current = current.down;
            else break;
        }
    }
    return false;
};

Skiplist.prototype.add = function(num) {
    let level = 0;
    let heads = [this.levels[0]];
    while (level < this.levels.length && Math.random() < 0.5) {
        if (!this.levels[level]) {
            this.levels[level] = new Node(-1);
            this.levels[level].down = this.levels[level + 1] || null;
        }
        heads.push(this.levels[level]);
        level++;
    }
    if (level === this.levels.length) {
        this.levels.push(new Node(-1));
    }
    let prev = null;
    for (let i = heads.length - 1; i >= 0; i--) {
        let node = heads[i];
        while (node.next && node.next.val < num) {
            node = node.next;
        }
        let newNode = new Node(num);
        newNode.next = node.next;
        node.next = newNode;
        if (prev) {
            newNode.down = prev;
        }
        prev = newNode;
    }
};

Skiplist.prototype.erase = function(num) {
    let current = this.levels[0];
    let found = false;
    while (current) {
        while (current.next && current.next.val < num) {
            current = current.next;
        }
        if (current.next && current.next.val === num) {
            current.next = current.next.next;
            found = true;
        }
        if (current.down) current = current.down;
        else break;
    }
    return found;
};

function Node(val) {
    this.val = val;
    this.next = null;
    this.down = null;
}