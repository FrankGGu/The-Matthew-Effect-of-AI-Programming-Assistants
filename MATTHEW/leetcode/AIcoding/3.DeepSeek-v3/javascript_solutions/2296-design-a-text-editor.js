class TextEditor {
    constructor() {
        this.left = [];
        this.right = [];
    }

    addText(text) {
        for (const c of text) {
            this.left.push(c);
        }
    }

    deleteText(k) {
        let count = 0;
        while (this.left.length > 0 && count < k) {
            this.left.pop();
            count++;
        }
        return count;
    }

    cursorLeft(k) {
        while (this.left.length > 0 && k > 0) {
            this.right.push(this.left.pop());
            k--;
        }
        return this.getLeftString();
    }

    cursorRight(k) {
        while (this.right.length > 0 && k > 0) {
            this.left.push(this.right.pop());
            k--;
        }
        return this.getLeftString();
    }

    getLeftString() {
        const len = Math.min(10, this.left.length);
        return this.left.slice(this.left.length - len).join('');
    }
}