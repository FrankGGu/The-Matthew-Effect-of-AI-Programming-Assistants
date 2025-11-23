class LockingTree {
    constructor(parent) {
        this.parent = parent;
        this.children = Array(parent.length).fill(null).map(() => []);
        for (let i = 0; i < parent.length; i++) {
            if (parent[i] !== -1) {
                this.children[parent[i]].push(i);
            }
        }
        this.lock = Array(parent.length).fill(0);
    }

    lock(num, user) {
        if (this.lock[num] === 0) {
            this.lock[num] = user;
            return true;
        }
        return false;
    }

    unlock(num, user) {
        if (this.lock[num] === user) {
            this.lock[num] = 0;
            return true;
        }
        return false;
    }

    isLockedAncestor(node) {
        while (node !== -1) {
            if (this.lock[node] !== 0) {
                return true;
            }
            node = this.parent[node];
        }
        return false;
    }

    hasLockedDescendant(node) {
        if (this.lock[node] !== 0) return true;

        for (let child of this.children[node]) {
            if (this.hasLockedDescendant(child)) return true;
        }

        return false;
    }

    unlockDescendants(node) {
        let unlocked = false;

        if (this.lock[node] !== 0) {
            this.lock[node] = 0;
            unlocked = true;
        }

        for (let child of this.children[node]) {
            unlocked = unlocked || this.unlockDescendants(child);
        }

        return unlocked;
    }

    upgrade(num, user) {
        if (this.lock[num] !== 0) return false;
        if (this.isLockedAncestor(num)) return false;
        if (!this.unlockDescendants(num)) return false;

        this.lock[num] = user;
        return true;
    }
}