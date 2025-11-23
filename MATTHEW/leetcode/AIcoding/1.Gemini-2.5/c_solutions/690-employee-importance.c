struct Employee* employeeMap[2001]; // Max ID is 2000, so size 2001 covers indices 0-2000.

int dfs(int employeeId) {
    struct Employee* emp = employeeMap[employeeId];
    if (emp == NULL) {
        return 0; // Should not happen if the input is valid and all subordinates exist.
    }

    int totalImportance = emp->importance;
    for (int i = 0; i < emp->subordinatesSize; ++i) {
        totalImportance += dfs(emp->subordinates[i]);
    }
    return totalImportance;
}

int getImportance(struct Employee** employees, int employeesSize, int id) {
    // Initialize the map with NULLs
    for (int i = 0; i < 2001; ++i) {
        employeeMap[i] = NULL;
    }

    // Populate the map: store pointers to Employee structs by their ID
    for (int i = 0; i < employeesSize; ++i) {
        employeeMap[employees[i]->id] = employees[i];
    }

    // Start the Depth-First Search from the given employee ID
    return dfs(id);
}