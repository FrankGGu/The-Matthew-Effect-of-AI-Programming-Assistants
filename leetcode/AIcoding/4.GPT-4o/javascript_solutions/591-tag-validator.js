var isValid = function(code) {
    const stack = [];
    const tagPattern = /<\/?([a-zA-Z][a-zA-Z0-9]*)\s*([^>]*)>/g;
    let pos = 0;

    while (pos < code.length) {
        const tagMatch = tagPattern.exec(code);
        if (!tagMatch) {
            return false;
        }
        const [fullMatch, tagName, attributes] = tagMatch;
        const tagStartPos = tagMatch.index;

        if (tagStartPos !== pos) {
            return false;
        }
        pos += fullMatch.length;

        if (fullMatch[1] === '/') {
            if (stack.length === 0 || stack.pop() !== tagName) {
                return false;
            }
        } else {
            if (attributes.includes(' ')) {
                return false;
            }
            stack.push(tagName);
        }
    }

    return stack.length === 0 && code.startsWith('<') && code.endsWith('>');
};