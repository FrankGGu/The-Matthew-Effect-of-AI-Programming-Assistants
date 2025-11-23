var NestedIterator = function(nestedList) {
    this.list = [];
    this.index = 0;

    function flatten(nestedList, arr) {
        for (let i = 0; i < nestedList.length; i++) {
            if (nestedList[i].isInteger()) {
                arr.push(nestedList[i].getInteger());
            } else {
                flatten(nestedList[i].getList(), arr);
            }
        }
    }

    flatten(nestedList, this.list);
};

NestedIterator.prototype.hasNext = function() {
    return this.index < this.list.length;
};

NestedIterator.prototype.next = function() {
    return this.list[this.index++];
};