class Solution {
    melt(df, id_vars, value_vars) {
        if (!df || df.length === 0) {
            return [
                [...id_vars, "variable", "value"]
            ];
        }

        const headers = df[0];
        const idVarIndices = id_vars.map(idVar => headers.indexOf(idVar));
        const valueVarIndices = value_vars.map(valueVar => headers.indexOf(valueVar));

        const result = [];
        result.push([...id_vars, "variable", "value"]);

        for (let i = 1; i < df.length; i++) {
            const row = df[i];
            const idVarValues = idVarIndices.map(idx => row[idx]);

            for (let j = 0; j < value_vars.length; j++) {
                const valueVarName = value_vars[j];
                const valueVarIndex = valueVarIndices[j];
                const value = row[valueVarIndex];
                result.push([...idVarValues, valueVarName, value]);
            }
        }

        return result;
    }
}