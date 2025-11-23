function pivot(data, indexCols, pivotCol, valueCol) {
    if (!data || data.length === 0) {
        return [];
    }

    const pivotedMap = new Map();
    const pivotValues = new Set();

    for (const row of data) {
        let indexKeyParts = [];
        let indexRowBase = {};
        for (const col of indexCols) {
            indexKeyParts.push(`${col}:${row[col]}`);
            indexRowBase[col] = row[col];
        }
        const indexKey = indexKeyParts.join('|');

        if (!pivotedMap.has(indexKey)) {
            pivotedMap.set(indexKey, { ...indexRowBase });
        }

        const currentPivotedRow = pivotedMap.get(indexKey);
        const pColValue = row[pivotCol];
        const vColValue = row[valueCol];

        if (pColValue !== undefined) {
            pivotValues.add(pColValue);
            currentPivotedRow[pColValue] = vColValue;
        }
    }

    const result = [];
    const sortedPivotValues = Array.from(pivotValues).sort((a, b) => {
        const numA = Number(a);
        const numB = Number(b);
        if (!isNaN(numA) && !isNaN(numB)) {
            return numA - numB;
        }
        return String(a).localeCompare(String(b));
    });

    for (const [indexKey, pivotedRow] of pivotedMap.entries()) {
        for (const pVal of sortedPivotValues) {
            if (!(pVal in pivotedRow)) {
                pivotedRow[pVal] = null;
            }
        }
        result.push(pivotedRow);
    }

    return result;
}