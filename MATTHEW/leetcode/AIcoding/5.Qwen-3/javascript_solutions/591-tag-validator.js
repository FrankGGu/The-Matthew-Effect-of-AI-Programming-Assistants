function tagValidator(content) {
    const stack = [];
    const tags = content.match(/<([^>]+)>/g);
    if (!tags) return content === '' ? 'true' : 'false';

    for (const tag of tags) {
        if (tag.startsWith('</')) {
            const name = tag.slice(2, -1);
            if (stack.length === 0 || stack[stack.length - 1] !== name) {
                return 'false';
            }
            stack.pop();
        } else {
            const name = tag.slice(1, -1);
            if (!/^[A-Z]+$/.test(name)) {
                return 'false';
            }
            stack.push(name);
        }
    }

    return stack.length === 0 ? 'true' : 'false';
}