var minTime = function(potions, materials, initial_materials, k) {
    const n = potions.length;
    const m = materials.length;

    // Convert k to BigInt for calculations
    const K_BIG = BigInt(k);

    // Convert all input arrays to BigInt arrays for consistent calculations
    const POTIONS_BIG = potions.map(BigInt);
    const MATERIALS_BIG = materials.map(row => row.map(BigInt));
    const INITIAL_MATERIALS_BIG = initial_materials.map(BigInt);

    // Check function: determines if it's possible to brew all potions within 'time' units.
    const check = (time) => {
        let totalMachineUnitsNeeded = 0n; // Use 0n for BigInt zero

        for (let i = 0; i < n; i++) { // Iterate through each potion type
            let currentPotionMachineUnitsNeeded = 0n;
            for (let j = 0; j < m; j++) { // Iterate through each material type
                // Calculate the total amount of material j required for POTIONS_BIG[i] units of potion i
                const requiredMaterialJ = POTIONS_BIG[i] * MATERIALS_BIG[j][i];

                // Calculate the amount of material j that needs to be produced by machines.
                // This is the difference if required amount exceeds initial amount.
                const neededToProduce = requiredMaterialJ > INITIAL_MATERIALS_BIG[j] ? 
                                        requiredMaterialJ - INITIAL_MATERIALS_BIG[j] : 0n;

                currentPotionMachineUnitsNeeded += neededToProduce;
            }
            totalMachineUnitsNeeded += currentPotionMachineUnitsNeeded;
        }

        // Calculate the total production capacity of k machines in 'time' units.
        // Each machine produces 1 unit of any material per unit of time.
        const totalMachineCapacity = K_BIG * time;

        // Return true if the total material units needed can be covered by machine capacity.
        return totalMachineUnitsNeeded <= totalMachineCapacity;
    };

    // Binary search for the minimum time.
    let low = 0n;
    // The maximum possible time can be estimated.
    // Max required material for one potion type (10^9 * 10^9) * 100 materials = 10^20.
    // Max total required for all 100 potion types = 100 * 10^20 = 10^22.
    // If k=1, time could be 10^22. A safe upper bound is 2 * 10^22.
    let high = 20000000000000000000000n; // 2 * 10^22
    let ans = high; // Initialize with a value that is definitely achievable (or larger than max possible)

    while (low <= high) {
        let mid = low + (high - low) / 2n; // Calculate mid using BigInt division
        if (check(mid)) {
            ans = mid; // If 'mid' time is sufficient, try for less time
            high = mid - 1n;
        } else {
            low = mid + 1n; // If 'mid' time is not sufficient, need more time
        }
    }

    // The problem signature expects a 'number' return type.
    // Convert the BigInt result back to a number.
    // Note: If the answer truly exceeds Number.MAX_SAFE_INTEGER, precision might be lost.
    // However, for typical LeetCode problems with this signature, the final answer fits.
    return Number(ans);
};