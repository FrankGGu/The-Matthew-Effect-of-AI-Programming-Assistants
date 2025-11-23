class TextEditor {
    constructor() {
        this.left = [];
        this.right = [];
    }

    addText(text) {
        for (const char of text) {
            this.left.push(char);
        }
    }

    deleteText(k) {
        let deletedCount = 0;
        while (k > 0 && this.left.length > 0) {
            this.left.pop();
            deletedCount++;
            k--;
        }
        return deletedCount;
    }

    cursorLeft(k) {
        while (k > 0 && this.left.length > 0) {
            this.right.push(this.left.pop());
            k--;
        }
        return this._getLeftString();
    }

    cursorRight(k) {
        while (k > 0 && this.right.length > 0) {
            this.left.push(this.right.pop());
            k--;
        }
        return this._getLeftString();
    }

    _getLeftString() {
        const len = this.left.length;
        if (len <= 10) {
            return this.left.join('');
        } else {
            return this.left.slice(len - 10).join('');
        }
    }
}