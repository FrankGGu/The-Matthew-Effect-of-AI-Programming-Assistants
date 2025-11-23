function interpret(command) {
    return command.replace(/G/g, 'G').replace(/\(al\)/g, 'al').replace(/\(\)/g, 'o');
}