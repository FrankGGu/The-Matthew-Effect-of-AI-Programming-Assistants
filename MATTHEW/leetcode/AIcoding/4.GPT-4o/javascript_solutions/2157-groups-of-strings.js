var groupStrings = function(strings) {
    const map = new Map();

    for (const str of strings) {
        let key = '';
        for (let i = 0; i < str.length; i++) {
            key += String.fromCharCode(((str.charCodeAt(i) - str.charCodeAt(0) + 26) % 26) + 97);
        }
        if (!map.has(key)) {
            map.set(key, []);
        }
        map.get(key).push(str);
    }

    return Array.from(map.values());
};