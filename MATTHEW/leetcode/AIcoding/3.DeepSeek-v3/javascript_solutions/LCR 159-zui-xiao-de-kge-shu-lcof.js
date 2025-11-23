var inventoryManagementIII = function(inventory, k) {
    inventory.sort((a, b) => a - b);
    return inventory.slice(0, k);
};