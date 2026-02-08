class TextEditor {
    constructor() {
        this.text = '';
        this.cursor = 0;
    }

    addText(text) {
        this.text = this.text.slice(0, this.cursor) + text + this.text.slice(this.cursor);
        this.cursor += text.length;
    }

    deleteText(k) {
        const deleteCount = Math.min(k, this.cursor);
        this.text = this.text.slice(0, this.cursor - deleteCount) + this.text.slice(this.cursor);
        this.cursor -= deleteCount;
    }

    cursorLeft(k) {
        this.cursor = Math.max(0, this.cursor - k);
        return this.getLast10Chars();
    }

    cursorRight(k) {
        this.cursor = Math.min(this.text.length, this.cursor + k);
        return this.getLast10Chars();
    }

    getLast10Chars() {
        return this.text.slice(Math.max(0, this.cursor - 10), this.cursor);
    }
}