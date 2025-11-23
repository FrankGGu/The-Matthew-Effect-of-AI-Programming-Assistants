class Skiplist {
    constructor() {
        this.MAX_LEVEL = 16;
        this.P = 0.5;
        this.level = 0;
        this.head = new SkiplistNode(-1, this.MAX_LEVEL);
    }

    randomLevel() {
        let level = 1;
        while (Math.random() < this.P && level < this.MAX_LEVEL) {
            level++;
        }
        return level;
    }

    search(target) {
        let curr = this.head;
        for (let i = this.level - 1; i >= 0; i--) {
            while (curr.forward[i] && curr.forward[i].val < target) {
                curr = curr.forward[i];
            }
        }
        curr = curr.forward[0];
        return curr && curr.val === target;
    }

    add(num) {
        let update = new Array(this.MAX_LEVEL).fill(null);
        let curr = this.head;
        for (let i = this.level - 1; i >= 0; i--) {
            while (curr.forward[i] && curr.forward[i].val < num) {
                curr = curr.forward[i];
            }
            update[i] = curr;
        }
        let level = this.randomLevel();
        if (level > this.level) {
            for (let i = this.level; i < level; i++) {
                update[i] = this.head;
            }
            this.level = level;
        }
        let newNode = new SkiplistNode(num, level);
        for (let i = 0; i < level; i++) {
            newNode.forward[i] = update[i].forward[i];
            update[i].forward[i] = newNode;
        }
    }

    erase(num) {
        let update = new Array(this.MAX_LEVEL).fill(null);
        let curr = this.head;
        for (let i = this.level - 1; i >= 0; i--) {
            while (curr.forward[i] && curr.forward[i].val < num) {
                curr = curr.forward[i];
            }
            update[i] = curr;
        }
        curr = curr.forward[0];
        if (curr && curr.val === num) {
            for (let i = 0; i < this.level; i++) {
                if (update[i].forward[i] !== curr) {
                    break;
                }
                update[i].forward[i] = curr.forward[i];
            }
            while (this.level > 1 && !this.head.forward[this.level - 1]) {
                this.level--;
            }
            return true;
        }
        return false;
    }
}

class SkiplistNode {
    constructor(val, level) {
        this.val = val;
        this.forward = new Array(level).fill(null);
    }
}