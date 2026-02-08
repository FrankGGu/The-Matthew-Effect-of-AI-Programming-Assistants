class NestedInteger {
    constructor() {
        this.value = null;
        this.list = [];
    }

    isInteger() {
        return this.value !== null;
    }

    add(elem) {
        this.list.push(elem);
    }

    setInteger(value) {
        this.value = value;
    }

    getInteger() {
        return this.value;
    }

    getList() {
        return this.list;
    }
}

var deserialize = function(s) {
    if (s[0] !== '[') {
        const ni = new NestedInteger();
        ni.setInteger(parseInt(s));
        return ni;
    }

    const stack = [];
    let num = '';
    let top = new NestedInteger();

    for (let i = 0; i < s.length; i++) {
        if (s[i] === '[') {
            stack.push(top);
            top = new NestedInteger();
        } else if (s[i] === ']') {
            if (num) {
                top.add(new NestedInteger(parseInt(num)));
                num = '';
            }
            const temp = top;
            top = stack.pop();
            top.add(temp);
        } else if (s[i] === ',') {
            if (num) {
                top.add(new NestedInteger(parseInt(num)));
                num = '';
            }
        } else {
            num += s[i];
        }
    }

    return top;
};