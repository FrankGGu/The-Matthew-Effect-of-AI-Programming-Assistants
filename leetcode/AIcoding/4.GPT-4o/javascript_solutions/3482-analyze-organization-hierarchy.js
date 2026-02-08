var getOrganizationInfo = function(orgChart) {
    const hierarchy = {};

    for (const employee of orgChart) {
        const { id, importance, subordinates } = employee;
        hierarchy[id] = { importance, subordinates };
    }

    const dfs = (id) => {
        let totalImportance = hierarchy[id].importance;
        for (const subId of hierarchy[id].subordinates) {
            totalImportance += dfs(subId);
        }
        return totalImportance;
    };

    const result = {};
    for (const id of Object.keys(hierarchy)) {
        result[id] = dfs(parseInt(id));
    }

    return result;
};