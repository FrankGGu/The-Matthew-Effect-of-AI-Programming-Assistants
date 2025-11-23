var LockingTree = function(parent) {
    this.parent = parent;
    this.locked = new Array(parent.length).fill(0);
    this.children = new Array(parent.length).fill().map(() => []);
    for (let i = 1; i < parent.length; i++) {
        this.children[parent[i]].push(i);
    }
};

LockingTree.prototype.lock = function(num, user) {
    if (this.locked[num] === 0) {
        this.locked[num] = user;
        return true;
    }
    return false;
};

LockingTree.prototype.unlock = function(num, user) {
    if (this.locked[num] === user) {
        this.locked[num] = 0;
        return true;
    }
    return false;
};

LockingTree.prototype.upgrade = function(num, user) {
    if (this.locked[num] !== 0) {
        return false;
    }

    let current = num;
    while (current !== -1) {
        if (this.locked[current] !== 0) {
            return false;
        }
        current = this.parent[current];
    }

    let hasLockedDescendant = false;
    const stack = [num];
    const toUnlock = [];

    while (stack.length > 0) {
        const node = stack.pop();
        for (const child of this.children[node]) {
            if (this.locked[child] !== 0) {
                hasLockedDescendant = true;
                toUnlock.push(child);
            }
            stack.push(child);
        }
    }

    if (!hasLockedDescendant) {
        return false;
    }

    for (const node of toUnlock) {
        this.locked[node] = 0;
    }

    this.locked[num] = user;
    return true;
};