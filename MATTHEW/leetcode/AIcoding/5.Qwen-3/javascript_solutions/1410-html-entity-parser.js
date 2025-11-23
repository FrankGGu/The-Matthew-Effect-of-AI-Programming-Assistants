function entityParser(text) {
    const entityMap = {
        "&quot;": '"',
        "&apos;": "'",
        "&amp;": "&",
        "&gt;": ">",
        "&lt;": "<",
        "&frasl;": "/"
    };

    let result = '';
    let i = 0;

    while (i < text.length) {
        let found = false;
        for (const [entity, char] of Object.entries(entityMap)) {
            if (text.startsWith(entity, i)) {
                result += char;
                i += entity.length;
                found = true;
                break;
            }
        }
        if (!found) {
            result += text[i];
            i++;
        }
    }

    return result;
}