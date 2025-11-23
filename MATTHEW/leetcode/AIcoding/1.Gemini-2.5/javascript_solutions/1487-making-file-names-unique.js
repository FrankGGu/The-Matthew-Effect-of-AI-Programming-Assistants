var getFolderNames = function(names) {
    const counts = new Map(); // Stores all names (original or generated) that have been used, and for each, the next suffix to try if it's used as a base.
    const result = [];

    for (const name of names) {
        let finalName = name;
        if (counts.has(name)) { // If the original 'name' has been seen before (either as an original or a generated unique name)
            let k = counts.get(name); // Get the next suffix to try for 'name'

            // Loop until we find a unique name
            while (counts.has(name + "(" + k + ")")) {
                k++;
                // This is the crucial optimization: update 'name's next suffix eagerly.
                // If 'name(k)' is taken, then 'name' should immediately point to 'k+1' for future queries.
                // This avoids re-checking 'name(1)', 'name(2)', etc. if 'name' is encountered again.
                counts.set(name, k); 
            }
            finalName = name + "(" + k + ")";
            counts.set(name, k + 1); // Update the original 'name's next suffix for future iterations
        }

        result.push(finalName);
        counts.set(finalName, 1); // Mark the chosen unique name as seen, and its next suffix is 1.
    }

    return result;
};