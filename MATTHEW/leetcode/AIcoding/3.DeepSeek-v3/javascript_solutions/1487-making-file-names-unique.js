var getFolderNames = function(names) {
    const nameMap = {};
    const result = [];

    for (const name of names) {
        if (!nameMap[name]) {
            nameMap[name] = 1;
            result.push(name);
        } else {
            let k = nameMap[name];
            let newName = `${name}(${k})`;
            while (nameMap[newName]) {
                k++;
                newName = `${name}(${k})`;
            }
            nameMap[name] = k + 1;
            nameMap[newName] = 1;
            result.push(newName);
        }
    }

    return result;
};