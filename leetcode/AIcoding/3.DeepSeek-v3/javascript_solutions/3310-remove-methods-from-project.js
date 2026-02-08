var removeMethods = function(project, methods) {
    const methodSet = new Set(methods);
    const lines = project.split('\n');
    const result = [];
    let inMethod = false;
    let currentMethod = '';
    let methodLines = [];

    for (const line of lines) {
        if (line.trim().startsWith('def ') && line.includes('(') && line.includes('):')) {
            if (inMethod) {
                result.push(...methodLines);
            }
            inMethod = true;
            currentMethod = line.trim().split('def ')[1].split('(')[0];
            methodLines = [line];
        } else if (inMethod) {
            if (line.trim() === '') {
                methodLines.push(line);
            } else if (line.trim().startsWith(' ') || line.trim().startsWith('\t')) {
                methodLines.push(line);
            } else {
                if (!methodSet.has(currentMethod)) {
                    result.push(...methodLines);
                }
                inMethod = false;
                currentMethod = '';
                methodLines = [];
                result.push(line);
            }
        } else {
            result.push(line);
        }
    }

    if (inMethod && !methodSet.has(currentMethod)) {
        result.push(...methodLines);
    }

    return result.join('\n');
};