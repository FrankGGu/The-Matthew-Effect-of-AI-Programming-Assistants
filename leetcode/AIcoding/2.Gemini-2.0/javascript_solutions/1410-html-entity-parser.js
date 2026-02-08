var entityParser = function(text) {
    const entities = {
        "&quot;": "\"",
        "&apos;": "'",
        "&amp;": "&",
        "&gt;": ">",
        "&lt;": "<",
        "&frasl;": "/"
    };

    let result = "";
    let i = 0;

    while (i < text.length) {
        if (text[i] === '&') {
            let found = false;
            for (const entity in entities) {
                if (text.substring(i, i + entity.length) === entity) {
                    result += entities[entity];
                    i += entity.length;
                    found = true;
                    break;
                }
            }
            if (!found) {
                result += text[i];
                i++;
            }
        } else {
            result += text[i];
            i++;
        }
    }

    return result;
};