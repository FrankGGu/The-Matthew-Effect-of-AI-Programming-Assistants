function analyzeOrganizationHierarchy(employees) {
    const adj = new Map();
    const allEmployeeIds = new Set();

    let ceoId = -1;

    for (const [id, managerId] of employees) {
        allEmployeeIds.add(id);

        if (!adj.has(id)) {
            adj.set(id, []);
        }

        if (managerId === -1) {
            ceoId = id;
        } else {
            if (!adj.has(managerId)) {
                adj.set(managerId, []);
            }
            adj.get(managerId).push(id);
        }
    }

    const analysis = new Map();
    for (const id of allEmployeeIds) {
        analysis.set(id, { direct: 0, total: 0 });
    }

    function dfs(employeeId) {
        const subordinates = adj.get(employeeId) || [];
        analysis.get(employeeId).direct = subordinates.length;

        let currentTotalSubordinates = 0;
        for (const subId of subordinates) {
            currentTotalSubordinates += (1 + dfs(subId));
        }
        analysis.get(employeeId).total = currentTotalSubordinates;
        return currentTotalSubordinates;
    }

    if (ceoId !== -1) {
        dfs(ceoId);
    }

    const result = [];
    const sortedEmployeeIds = Array.from(allEmployeeIds).sort((a, b) => a - b);

    for (const id of sortedEmployeeIds) {
        const { direct, total } = analysis.get(id);
        result.push([id, direct, total]);
    }

    return result;
}