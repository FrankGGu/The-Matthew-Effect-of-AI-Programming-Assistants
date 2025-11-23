var inventoryManagementII = function(orders, m, k) {
    let maxDaysSingleOrder = 0;
    let totalSupplierDays = 0;

    for (let i = 0; i < orders.length; i++) {
        let days = Math.ceil(orders[i] / k);

        totalSupplierDays += days;
        if (days > maxDaysSingleOrder) {
            maxDaysSingleOrder = days;
        }
    }

    if (orders.length === 0) {
        return 0;
    }
    if (maxDaysSingleOrder === 0) {
        return 0;
    }

    let low = maxDaysSingleOrder;
    let high = totalSupplierDays;
    let ans = totalSupplierDays;

    while (low <= high) {
        let mid = low + Math.floor((high - low) / 2);

        // Check if it's possible to complete all orders within 'mid' days.
        // This is a standard makespan minimization problem.
        // We need to ensure that:
        // 1. No single order takes longer than 'mid' days (handled by setting low = maxDaysSingleOrder).
        // 2. The total work (totalSupplierDays) can be covered by 'm' suppliers,
        //    each working for 'mid' days. Total capacity = m * mid.
        if (totalSupplierDays <= m * mid) {
            ans = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }

    return ans;
};