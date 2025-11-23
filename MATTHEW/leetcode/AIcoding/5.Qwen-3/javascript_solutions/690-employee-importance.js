var getImportance = function(employees, id) {
    const map = new Map();
    for (const emp of employees) {
        map.set(emp.id, emp);
    }

    const dfs = (currentId) => {
        const current = map.get(currentId);
        let total = current.importance;
        for (const sub of current.subordinates) {
            total += dfs(sub);
        }
        return total;
    };

    return dfs(id);
};