var entityParser = function(text) {
    const replacements = {
        "&quot;": '"',
        "&apos;": "'",
        "&amp;": "&",
        "&gt;": ">",
        "&lt;": "<",
        "&frasl;": "/"
    };

    // The order of alternatives in the regex matters for overlapping matches,
    // though for these specific entities, they mostly don't overlap in problematic ways
    // (e.g., one being a prefix of another, except for the '&' character itself).
    // It's generally good practice to list longer or more specific patterns first,
    // but for distinct entities like these, the order often doesn't change correctness.
    // The key is that `&amp;` is replaced by `&`, and the `replace` function
    // will continue searching *after* the matched entity, preventing re-parsing
    // of the newly inserted character.
    const regex = /(&quot;|&apos;|&amp;|&gt;|&lt;|&frasl;)/g;

    return text.replace(regex, match => replacements[match]);
};