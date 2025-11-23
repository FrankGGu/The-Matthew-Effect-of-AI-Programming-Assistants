var removeMethods = function(methods, calls) {
    const used = new Set();
    for (const call of calls) {
        used.add(call[0]);
    }
    const result = [];
    for (const method of methods) {
        if (!used.has(method)) {
            result.push(method);
        }
    }
    return result;
};