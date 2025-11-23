class TextEditor {
    constructor() {
        this.text = "";
        this.cursor = 0;
    }

    insertText(text) {
        this.text = this.text.substring(0, this.cursor) + text + this.text.substring(this.cursor);
        this.cursor += text.length;
    }

    deleteText(k) {
        const deleteCount = Math.min(k, this.cursor);
        this.text = this.text.substring(0, this.cursor - deleteCount) + this.text.substring(this.cursor);
        this.cursor -= deleteCount;
        return deleteCount;
    }

    cursorLeft(k) {
        this.cursor = Math.max(0, this.cursor - k);
        return this.cursor;
    }

    cursorRight(k) {
        this.cursor = Math.min(this.text.length, this.cursor + k);
        return this.cursor;
    }

    cursorLeft(k) {
        this.cursor = Math.max(0, this.cursor - k);
        return this.cursor;
    }

    cursorRight(k) {
        this.cursor = Math.min(this.text.length, this.cursor + k);
        return this.cursor;
    }

    result() {
        if (this.cursor < 10) {
            return this.text.substring(0, this.cursor);
        } else {
            return this.text.substring(this.cursor - 10, this.cursor);
        }
    }

    cursorLeft(k) {
        this.cursor = Math.max(0, this.cursor - k);
        return this.cursor;
    }

    cursorRight(k) {
        this.cursor = Math.min(this.text.length, this.cursor + k);
        return this.cursor;
    }

    result() {
        if (this.cursor < 10) {
            return this.text.substring(0, this.cursor);
        } else {
            return this.text.substring(this.cursor - 10, this.cursor);
        }
    }

    getText(k) {
        return this.result();
    }
}