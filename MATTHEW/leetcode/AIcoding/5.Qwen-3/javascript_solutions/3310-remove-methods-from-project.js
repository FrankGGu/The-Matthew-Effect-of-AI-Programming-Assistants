function removeMethodsFromProject(methods) {
    const result = [];
    for (const method of methods) {
        if (!method.startsWith("get") && !method.startsWith("set")) {
            result.push(method);
        }
    }
    return result;
}