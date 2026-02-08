class NestedIterator {
    constructor(nestedList) {
        this.list = [];
        this.index = 0;
        this.flatten(nestedList);
    }

    flatten(nestedList) {
        for (const item of nestedList) {
            if (item.isInteger()) {
                this.list.push(item.getInteger());
            } else {
                this.flatten(item.getList());
            }
        }
    }

    next() {
        return this.list[this.index++];
    }

    hasNext() {
        return this.index < this.list.length;
    }
}