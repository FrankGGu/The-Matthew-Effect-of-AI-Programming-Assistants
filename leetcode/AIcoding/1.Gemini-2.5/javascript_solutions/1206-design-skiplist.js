class SkiplistNode {
    constructor(val, level) {
        this.val = val;
        this.next = new Array(level).fill(null);
    }
}

class Skiplist {
    constructor() {
        this.MAX_LEVEL = 16;
        this.P = 0.5;
        this.head = new SkiplistNode(-1, this.MAX_LEVEL);
        this.level = 0;
    }

    randomLevel() {
        let lvl = 1;
        while (Math.random() < this.P && lvl < this.MAX_LEVEL) {
            lvl++;
        }
        return lvl;
    }

    search(target) {
        let curr = this.head;
        for (let i = this.level; i >= 0; i--) {
            while (curr.next[i] && curr.next[i].val < target) {
                curr = curr.next[i];
            }
        }
        curr = curr.next[0];
        return curr !== null && curr.val === target;
    }

    add(num) {
        const update = new Array(this.MAX_LEVEL).fill(null);
        let curr = this.head;

        for (let i = this.level; i >= 0; i--) {
            while (curr.next[i] && curr.next[i].val < num) {
                curr = curr.next[i];
            }
            update[i] = curr;
        }

        const nodeLevel = this.randomLevel();
        const newNode = new SkiplistNode(num, nodeLevel);

        if (nodeLevel - 1 > this.level) {
            for (let i = this.level + 1; i < nodeLevel; i++) {
                update[i] = this.head;
            }
            this.level = nodeLevel - 1;
        }

        for (let i = 0; i < nodeLevel; i++) {
            newNode.next[i] = update[i].next[i];
            update[i].next[i] = newNode;
        }
    }

    erase(num) {
        const update = new Array(this.MAX_LEVEL).fill(null);
        let curr = this.head;
        let found = false;

        for (let i = this.level; i >= 0; i--) {
            while (curr.next[i] && curr.next[i].val < num) {
                curr = curr.next[i];
            }
            update[i] = curr;
        }

        curr = curr.next[0];
        if (curr === null || curr.val !== num) {
            return false;
        }
        found = true;

        for (let i = 0; i <= this.level; i++) {
            if (update[i].next[i] === curr) {
                update[i].next[i] = curr.next[i];
            }
        }

        while (this.level > 0 && this.head.next[this.level] === null) {
            this.level--;
        }

        return found;
    }
}