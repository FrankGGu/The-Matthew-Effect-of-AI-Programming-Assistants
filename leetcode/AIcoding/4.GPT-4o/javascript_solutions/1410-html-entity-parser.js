var entityParser = function(text) {
    const entities = {
        '&quot;': '"',
        '&apos;': "'",
        '&amp;': '&',
        '&gt;': '>',
        '&lt;': '<',
        '&frasl;': '/',
    };

    return text.replace(/&[a-zA-Z0-9#]+;/g, match => entities[match] || match);
};