var getFolderNames = function(names) {
    const seen = new Map();
    const result = [];

    for (const name of names) {
        if (!seen.has(name)) {
            seen.set(name, 1);
            result.push(name);
        } else {
            let k = seen.get(name);
            let newName = `${name}(${k})`;
            while (seen.has(newName)) {
                k++;
                newName = `${name}(${k})`;
            }
            seen.set(name, k + 1);
            seen.set(newName, 1);
            result.push(newName);
        }
    }

    return result;
};