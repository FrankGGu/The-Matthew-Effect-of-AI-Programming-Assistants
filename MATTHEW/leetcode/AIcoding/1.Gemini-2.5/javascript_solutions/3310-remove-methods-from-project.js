var removeMethods = function(obj) {
    for (const key of Object.getOwnPropertyNames(obj)) {
        if (typeof obj[key] === 'function') {
            delete obj[key];
        }
    }
    return obj;
};