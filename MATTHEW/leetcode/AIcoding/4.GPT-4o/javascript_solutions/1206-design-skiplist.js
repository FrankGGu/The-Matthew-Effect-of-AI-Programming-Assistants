class Skiplist {
    constructor() {
        this.head = new Array(32).fill(null).map(() => new Node(-1));
        this.levels = 1;
    }

    search(target) {
        let curr = this.head;
        for (let i = this.levels - 1; i >= 0; i--) {
            while (curr[i] && curr[i].val < target) {
                curr = curr[i].next;
            }
        }
        curr = curr[0];
        return curr && curr.val === target;
    }

    add(num) {
        let curr = this.head;
        let update = new Array(this.levels).fill(null);
        for (let i = this.levels - 1; i >= 0; i--) {
            while (curr[i] && curr[i].val < num) {
                curr = curr[i].next;
            }
            update[i] = curr;
        }
        curr = curr[0];

        if (curr && curr.val === num) return;

        let newLevel = this.randomLevel();
        if (newLevel > this.levels) {
            for (let i = this.levels; i < newLevel; i++) {
                update[i] = this.head[i];
            }
            this.levels = newLevel;
        }

        let newNode = new Node(num);
        for (let i = 0; i < newLevel; i++) {
            newNode.next[i] = update[i].next[i];
            update[i].next[i] = newNode;
        }
    }

    erase(num) {
        let curr = this.head;
        let update = new Array(this.levels).fill(null);
        for (let i = this.levels - 1; i >= 0; i--) {
            while (curr[i] && curr[i].val < num) {
                curr = curr[i].next;
            }
            update[i] = curr;
        }
        curr = curr[0];

        if (!curr || curr.val !== num) return false;

        for (let i = 0; i < this.levels; i++) {
            if (update[i].next[i] !== curr) break;
            update[i].next[i] = curr.next[i];
        }

        while (this.levels > 1 && this.head[this.levels - 1].next[this.levels - 1] === null) {
            this.levels--;
        }
        return true;
    }

    randomLevel() {
        let level = 1;
        while (Math.random() < 0.5 && level < 32) {
            level++;
        }
        return level;
    }
}

class Node {
    constructor(val) {
        this.val = val;
        this.next = new Array(32).fill(null);
    }
}