#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>
#include <algorithm>

using namespace std;

struct Node {
    string name;
    unordered_map<string, Node*> children;
};

string serialize(Node* node, unordered_map<string, vector<Node*>>& signatures) {
    if (node->children.empty()) {
        return "()";
    }

    vector<string> childSignatures;
    for (auto& [name, child] : node->children) {
        childSignatures.push_back(make_pair(name, serialize(child, signatures)));
    }

    sort(childSignatures.begin(), childSignatures.end());

    string signature = "(";
    for (auto& [name, childSignature] : childSignatures) {
        signature += name + childSignature;
    }
    signature += ")";

    signatures[signature].push_back(node);
    return signature;
}

void removeDuplicateFolders(Node* node, unordered_map<string, vector<Node*>>& signatures) {
    for (auto& [name, child] : node->children) {
        removeDuplicateFolders(child, signatures);
    }

    for (auto& [signature, nodes] : signatures) {
        if (nodes.size() > 1) {
            for (int i = 1; i < nodes.size(); ++i) {
                delete nodes[i];
                nodes[i] = nullptr;
            }
        }
    }

    for (auto& [signature, nodes] : signatures) {
        if (nodes.size() > 1) {
            for (int i = 1; i < nodes.size(); ++i) {
                if (nodes[i] == nullptr) continue;
                Node* parent = nullptr;
                for (auto& [parentName, child] : node->children) {
                  if (child == nodes[i]) {
                    parent = node;
                    node->children.erase(parentName);
                    break;
                  }
                }
            }
        }
    }
}

void getPaths(Node* node, vector<vector<string>>& result, vector<string>& path) {
    for (auto& [name, child] : node->children) {
        path.push_back(name);
        getPaths(child, result, path);
        path.pop_back();
    }

    if (node->children.empty()) {
        result.push_back(path);
    }
}

vector<vector<string>> deleteDuplicateFolder(vector<vector<string>>& paths) {
    Node* root = new Node();
    root->name = "";

    for (auto& path : paths) {
        Node* current = root;
        for (string& folder : path) {
            if (current->children.find(folder) == current->children.end()) {
                current->children[folder] = new Node();
                current->children[folder]->name = folder;
            }
            current = current->children[folder];
        }
    }

    unordered_map<string, vector<Node*>> signatures;
    serialize(root, signatures);

    removeDuplicateFolders(root, signatures);

    vector<vector<string>> result;
    vector<string> path;
    getPaths(root, result, path);

    sort(result.begin(), result.end());

    return result;
}