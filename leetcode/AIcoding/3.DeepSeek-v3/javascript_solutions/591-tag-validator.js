var isValid = function(code) {
    const stack = [];
    let i = 0;
    const n = code.length;

    while (i < n) {
        if (i > 0 && stack.length === 0) return false;

        if (code.startsWith("<![CDATA[", i)) {
            let j = i + 9;
            i = code.indexOf("]]>", j);
            if (i === -1) return false;
            i += 3;
        } else if (code.startsWith("</", i)) {
            let j = i + 2;
            i = code.indexOf(">", j);
            if (i === -1) return false;
            const tagName = code.slice(j, i);
            if (stack.length === 0 || stack.pop() !== tagName) return false;
            i++;
        } else if (code.startsWith("<", i)) {
            let j = i + 1;
            i = code.indexOf(">", j);
            if (i === -1) return false;
            const tagName = code.slice(j, i);
            if (tagName.length < 1 || tagName.length > 9) return false;
            for (const c of tagName) {
                if (c < 'A' || c > 'Z') return false;
            }
            stack.push(tagName);
            i++;
        } else {
            i++;
        }
    }

    return stack.length === 0;
};