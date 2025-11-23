var getFolderNames = function(names) {
    const map = new Map();
    const result = [];

    for (const name of names) {
        if (!map.has(name)) {
            map.set(name, 1);
            result.push(name);
        } else {
            let newName = `${name}(${map.get(name)})`;
            while (map.has(newName)) {
                map.set(name, map.get(name) + 1);
                newName = `${name}(${map.get(name)})`;
            }
            map.set(newName, 1);
            map.set(name, map.get(name) + 1);
            result.push(newName);
        }
    }

    return result;
};