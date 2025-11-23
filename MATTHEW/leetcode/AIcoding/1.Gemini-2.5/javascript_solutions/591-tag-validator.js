var isValid = function(code) {
    let n = code.length;
    if (n === 0) return false;

    let i = 0;
    let tagStack = [];

    // The entire string must be enclosed within a single pair of tags.
    // So, the first thing we encounter must be an opening tag.
    if (code[i] !== '<') {
        return false;
    }

    let firstTagEnd = code.indexOf('>', i);
    if (firstTagEnd === -1) { // No closing '>' for the first tag
        return false;
    }

    let firstTagName = code.substring(i + 1, firstTagEnd);

    // Validate the first tag name
    if (firstTagName.length < 1 || firstTagName.length > 9) {
        return false;
    }
    for (let k = 0; k < firstTagName.length; k++) {
        if (firstTagName[k] < 'A' || firstTagName[k] > 'Z') {
            return false;
        }
    }

    tagStack.push(firstTagName);
    i = firstTagEnd + 1;

    // Parse the content and nested tags
    while (i < n) {
        // If the tagStack is empty, it means the outermost tag has been closed.
        // Any further characters mean there's content or tags outside the single root tag.
        if (tagStack.length === 0) {
            return false;
        }

        // Check for CDATA section
        if (i + 8 < n && code.substring(i, i + 9) === "<![CDATA[") {
            let cdataEnd = code.indexOf("]]>", i + 9);
            if (cdataEnd === -1) { // CDATA not properly closed
                return false;
            }
            i = cdataEnd + 3;
        }
        // Check for closing tag
        else if (i + 1 < n && code.substring(i, i + 2) === "</") {
            let j = i + 2;
            let tagName = "";
            while (j < n && code[j] !== '>') {
                tagName += code[j];
                j++;
            }
            if (j === n || code[j] !== '>') { // No closing '>' for the tag
                return false;
            }

            // Validate closing tag name
            if (tagName.length < 1 || tagName.length > 9) {
                return false;
            }
            for (let k = 0; k < tagName.length; k++) {
                if (tagName[k] < 'A' || tagName[k] > 'Z') {
                    return false;
                }
            }

            if (tagStack.length === 0 || tagStack[tagStack.length - 1] !== tagName) { // Mismatched or no opening tag
                return false;
            }
            tagStack.pop();
            i = j + 1;
        }
        // Check for opening tag
        else if (i < n && code[i] === '<') {
            let j = i + 1;
            let tagName = "";
            while (j < n && code[j] !== '>') {
                tagName += code[j];
                j++;
            }
            if (j === n || code[j] !== '>') { // No closing '>' for the tag
                return false;
            }

            // Validate opening tag name
            if (tagName.length < 1 || tagName.length > 9) {
                return false;
            }
            for (let k = 0; k < tagName.length; k++) {
                if (tagName[k] < 'A' || tagName[k] > 'Z') {
                    return false;
                }
            }

            tagStack.push(tagName);
            i = j + 1;
        }
        // Regular character (content)
        else {
            // Content is allowed only if there is an open tag.
            // The `if (tagStack.length === 0) return false;` at the beginning of the loop handles this.
            i++;
        }
    }

    // After parsing the entire string, the tagStack must be empty.
    // This confirms all tags are properly closed, including the outermost one.
    return tagStack.length === 0;
};