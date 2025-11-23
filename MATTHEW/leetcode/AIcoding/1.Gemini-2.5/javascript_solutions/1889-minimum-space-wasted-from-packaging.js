var minWastedSpace = function(packages, boxes) {
    // Sort packages in ascending order to efficiently process them.
    packages.sort((a, b) => a - b);

    const N = packages.length;

    // Determine the maximum package size to set the bounds for frequency arrays.
    // Since packages are sorted, the last element is the maximum.
    let maxPackageSize = packages[N - 1];

    // packageCounts[i] stores the frequency of packages of size i.
    const packageCounts = new Array(maxPackageSize + 1).fill(0);
    for (const p of packages) {
        packageCounts[p]++;
    }

    // prefixPackageCounts[i] stores the total number of packages with size <= i.
    // prefixPackageSums[i] stores the sum of sizes of all packages with size <= i.
    const prefixPackageCounts = new Array(maxPackageSize + 1).fill(0);
    const prefixPackageSums = new Array(maxPackageSize + 1).fill(0);

    for (let i = 1; i <= maxPackageSize; i++) {
        prefixPackageCounts[i] = prefixPackageCounts[i - 1] + packageCounts[i];
        prefixPackageSums[i] = prefixPackageSums[i - 1] + packageCounts[i] * i;
    }

    let minTotalWastedSpace = Infinity;

    // Iterate through each supplier's set of boxes.
    for (const supplierBoxes of boxes) {
        // Sort the current supplier's boxes in ascending order.
        supplierBoxes.sort((a, b) => a - b);

        let currentWastedSpace = 0;
        // lastBoxMaxPackageSizeHandled tracks the maximum package size that
        // any of the previous boxes from this supplier could accommodate.
        // This helps in finding "newly covered" packages by the current box.
        let lastBoxMaxPackageSizeHandled = 0; 
        let totalPackagesHandled = 0;

        // Iterate through each box size provided by the current supplier.
        for (const boxSize of supplierBoxes) {
            // The effective maximum package size this box can handle, capped by
            // the actual max package size to avoid processing non-existent package sizes.
            const currentBoxMaxPackageSize = Math.min(boxSize, maxPackageSize);

            // Calculate the number of packages that are now handled by this box,
            // which were not handled by any smaller boxes from this supplier.
            // These are packages with size p such that lastBoxMaxPackageSizeHandled < p <= currentBoxMaxPackageSize.
            const numPackagesForThisBox = prefixPackageCounts[currentBoxMaxPackageSize] - prefixPackageCounts[lastBoxMaxPackageSizeHandled];

            if (numPackagesForThisBox > 0) {
                // Calculate the sum of sizes of these newly handled packages.
                const sumOfThesePackages = prefixPackageSums[currentBoxMaxPackageSize] - prefixPackageSums[lastBoxMaxPackageSizeHandled];

                // Add the wasted space for these packages: (number of packages * box size) - sum of their actual sizes.
                currentWastedSpace += (numPackagesForThisBox * boxSize) - sumOfThesePackages;
                totalPackagesHandled += numPackagesForThisBox;
            }

            // Update lastBoxMaxPackageSizeHandled for the next iteration.
            lastBoxMaxPackageSizeHandled = currentBoxMaxPackageSize;

            // Optimization: If all packages are handled, no need to check larger boxes from this supplier.
            if (totalPackagesHandled === N) {
                break;
            }
        }

        // If this supplier successfully packaged all packages, update the minimum wasted space.
        if (totalPackagesHandled === N) {
            minTotalWastedSpace = Math.min(minTotalWastedSpace, currentWastedSpace);
        }
    }

    // If minTotalWastedSpace is still Infinity, it means no supplier could package all packages.
    if (minTotalWastedSpace === Infinity) {
        return -1;
    } else {
        // The problem statement does not specify a modulo, and 10^10 fits within JavaScript's safe integer range (2^53 - 1).
        return minTotalWastedSpace;
    }
};